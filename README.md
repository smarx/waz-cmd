Waz-Cmd
=======

Installation
------------

To install, just `gem install waz-cmd`

Basic usage
-----------

    c:\>waz generate certificates
    Writing certificate to 'c:\users\smarx/.waz/cert.pem'
    Writing certificate in .cer form to 'c:\users\smarx/.waz/cert.cer'
    Writing key to 'c:\users\smarx/.waz/key.pem'

    To use the new certificate, upload 'c:\users\smarx/.waz/cert.cer' as a management certificate in the Windows Azure portal (https://windows.azure.com)

    c:\>waz set subscriptionId XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX

    c:\>waz deploy blobedit staging c:\repositories\smarxrole\packages\ExtraSmall.cspkg c:\repositories\smarxrole\packages\ServiceConfiguration.blobedit.cscfg
    Waiting for operation to complete...
    Operation succeeded (200)

Documentation
-------------

Just run `waz help` for full documentation.
