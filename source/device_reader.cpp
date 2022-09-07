#include <stdio.h>
#include <stdlib.h>

#include "lib/ini/INIReader.h"
#include "lib/serial/SerialPort.h"

#include "device_reader.h"

void initSerialPort(SerialPort &serialPort, std::string device, speed_t speed, int bpw, std::string parity,
                    int stopbits)
{
    serialPort.SetDevice(device);

    serialPort.SetBaudRate(speed);

    switch (bpw)
    {
        case 5:
            serialPort.SetNumDataBits(NumDataBits::FIVE);
            break;
        case 6:
            serialPort.SetNumDataBits(NumDataBits::SIX);
            break;
        case 7:
            serialPort.SetNumDataBits(NumDataBits::SEVEN);
            break;
        case 8:
            serialPort.SetNumDataBits(NumDataBits::EIGHT);
            break;
        default:
            serialPort.SetNumDataBits(NumDataBits::EIGHT);
            break;
    }

    if (!parity.compare("none"))
        serialPort.SetParity(Parity::NONE);
    else if (!parity.compare("even"))
        serialPort.SetParity(Parity::EVEN);
    else if (!parity.compare("odd"))
        serialPort.SetParity(Parity::ODD);
    else
        serialPort.SetParity(Parity::NONE);

    switch (stopbits)
    {
        case 1:
            serialPort.SetNumStopBits(NumStopBits::ONE);
            break;
        case 2:
            serialPort.SetNumStopBits(NumStopBits::TWO);
            break;
        default:
            serialPort.SetNumStopBits(NumStopBits::ONE);
            break;
    }
}

void deinitSerialPort(SerialPort &serialPort)
{
    serialPort.Close();
}

int main(int argc, char **argv)
{
    INIReader iniReader(SETTING_FILE);

    SerialPort serialPort;
    initSerialPort(serialPort,
                   iniReader.Get("BATTERY", "device", "/dev/ttyO1"),
                   iniReader.GetInteger("BATTERY", "speed", 9600),
                   iniReader.GetInteger("BATTERY", "bpw", 8),
                   iniReader.Get("BATTERY", "parity", "none"),
                   iniReader.GetInteger("BATTERY", "stopbits", 1));

    serialPort.Open();

    while (1)
    {
        std::string readData;


        serialPort.Read(readData);

        std::cout << "Received data: " << readData << std::endl;
        std::cout.flush();

        readData.erase(readData.find('\n', 0));
        if (!readData.compare("exit"))
            break;
    }

    deinitSerialPort(serialPort);
    return 0;
}
