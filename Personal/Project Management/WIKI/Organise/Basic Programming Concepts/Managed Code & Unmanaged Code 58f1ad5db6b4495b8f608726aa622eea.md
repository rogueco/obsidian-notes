# Managed Code & Unmanaged Code

Created: July 6, 2020 10:53 PM

## Managed Code

The code, which is developed in .NET framework, is known as managed code. This code is directly executed by CLR with help of managed code execution. Any language that is written in .NET Framework is managed code.

Managed code uses CLR which in turns looks after your applications by managing memory, handling security, allowing cross - language debugging, and so on.

Managed code is not compiled to machine code but to an intermediate language which is interpreted and executed by some service on a machine and is therefore operating within a (hopefully!) secure framework which handles dangerous things like memory and threads for you. In modern usage this frequently means .NET but does not have to.

## Unmanaged Code

The code, which is developed outside .NET, Framework is known as unmanaged code.

Unmanaged code is compiled to machine code and therefore executed by the OS directly. It therefore has the ability to do damaging/powerful things Managed code does not. This is how everything used to work, so typically it's associated with old stuff like .dlls.