# utsa

Micro [RFC 3161](https://www.ietf.org/rfc/rfc3161.txt) Time-Stamp server written in C.

## What is RFC 3161?

An RFC 3161 time-stamp is basically a cryptographic signature with a date attached.

Roughly, it works as follow:

1. A client application sends an hash of the data it wants to time-stamp to a Time-Stamp authority server.
2. The Time-Stamp authority server retrieves the current date, concatenates it with the hash and uses its private key to create the time-stamp (kind of like a signature).
3. The Time-Stamp authority server returns the generated time-stamp to the client application.

Then a client can verify the piece of data with the time-stamp using the Certificate Authority of the time-stamp key pair (X509 certificates).

It gives a cryptographic proof of a piece of data content, for example a file, at a given time.

Some use cases:

- Time-stamp log files at rotation time.
- Time-stamp file at upload to prove it was delivered in due time or not.

## Quick (and dirty) Testing

Here a few steps to quickly try out utsa, for production setup, please compile civetweb externally and create proper CA and certificates:

.. sourcecode:: bash

    # Building with civetweb embedded (will recover civetweb from github).
    # Note: the BUNDLE_CIVETWEB option is only here for fast testing purpose
    # The recommended way to deploy uts-server in production is to build civetweb
    # separatly and to link against it.
    $ cmake . -DBUNDLE_CIVETWEB=ON
    $ make
    
    # Create some test certificates.
    $ ./tests/cfg/pki/create_tsa_certs
    
    # Launching the time-stamp server with test configuration in debug mode.
    $ ./utsa -c tests/cfg/utsa.conf -D
    
    # In another shell, launching a time-stamp script on the README.md file.
    $ ./goodies/timestamp-file.sh -i README.md -u http://localhost:2020 -r -O "-cert";

    # Verify the time-stamp.
    $ openssl ts -verify -in README.md.tsr -data README.rst -CAfile ./tests/cfg/pki/tsaca.pem

    # Display the time-stamp content.
    $ openssl ts -reply -in README.md.tsr -text
