﻿class Pipe
{
    ; ===================================================================================================================
    ; INSTANCE VARIABLES
    ; ===================================================================================================================
    Handle  := 0  ; The pipe Handle.
    oStream := 0  ; File Object.


    ; ===================================================================================================================
    ; CONSTRUCTOR
    ; ===================================================================================================================
    __New(Handle)
    {
        this.Handle := Handle
    }


    ; ===================================================================================================================
    ; DESTRUCTOR
    ; ===================================================================================================================
    __Delete()
    {
        this.Close()
    }


    ; ===================================================================================================================
    ; PRIVATE METHODS
    ; ===================================================================================================================
    Stream[]
    {
        get
        {
            if !this.Handle
                throw Exception("Subprocess.Pipe class: Stream[].", -1, "The pipe Handle was closed.")
            If !this.oStream
                if !( this.oStream := FileOpen(this.Handle,"h") )
                    throw Exception("Subprocess.Pipe class: Stream[].", -1, "FileOpen has failed.")
            return this.oStream
        }
    }


    ; ===================================================================================================================
    ; PUBLIC METHODS
    ; ===================================================================================================================
    Close()
    {
        this.oStream := 0
        DllCall("Kernel32.dll\CloseHandle", "Ptr", this.Handle)
        this.Handle := 0
    }

    Encoding[]
    {
        get {
            return this.Stream.Encoding
        }

        set {
            return this.Stream.Encoding := value
        }
    }
}
