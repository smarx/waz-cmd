Waz-Cmd
=======

Installation
------------

To install, just `gem install waz-cmd`

Example usage
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

    c:\>waz show deployment blobedit staging
    STAGING
        Label:          ExtraSmall.cspkg2011-07-0120:54:04
        Name:           27efeebeb18e4eb582a2e8fa0883957e
        Status:         Running
        Url:            http://78a9fdb38bc442238739b1154ea78cda.cloudapp.net/
        SDK version:    #1.4.20407.2049
    ROLES
        WebRole (WA-GUEST-OS-2.5_201104-01)
            2 Ready (use --expand to see details)
    ENDPOINTS
        157.55.181.17:80 on WebRole

    c:\>waz swap blobedit
    Waiting for operation to complete...
    Operation succeeded (200)

    c:\>waz show deployment blobedit production
    PRODUCTION
        Label:          ExtraSmall.cspkg2011-07-0120:54:04
        Name:           27efeebeb18e4eb582a2e8fa0883957e
        Status:         Running
        Url:            http://blobedit.cloudapp.net/
        SDK version:    #1.4.20407.2049
    ROLES
        WebRole (WA-GUEST-OS-2.5_201104-01)
            2 Ready (use --expand to see details)
    ENDPOINTS
        157.55.181.17:80 on WebRole

    c:\>waz show configuration blobedit production
    WebRole
        Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString: UseDevelopmentStorage=true
        GitUrl: git://github.com/smarx/blobedit
        DataConnectionString: DefaultEndpointsProtocol=http;AccountName=YOURACCOUNT;AccountKey=YOURKEY
        ContainerName:
        NumProcesses: 4

Documentation
-------------

Run `waz help` for full documentation.
