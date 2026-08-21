Add-Type -AssemblyName PresentationFramework

# Define the XAML UI with icons
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Title="Control Panel Launcher" Height="350" Width="400">
    <Grid>
        <StackPanel VerticalAlignment="Center" HorizontalAlignment="Center">
            <Button Name="LocalUsersBtn" Width="250" Margin="10">
                <StackPanel Orientation="Horizontal">
                    <Image Source="user.png" Width="24" Height="24" Margin="5"/>
                    <TextBlock Text="Local Users and Groups"/>
                </StackPanel>
            </Button>
            <Button Name="FirewallBtn" Width="250" Margin="10">
                <StackPanel Orientation="Horizontal">
                    <Image Source="firewall.png" Width="24" Height="24" Margin="5"/>
                    <TextBlock Text="Windows Firewall"/>
                </StackPanel>
            </Button>
            <Button Name="FeaturesBtn" Width="250" Margin="10">
                <StackPanel Orientation="Horizontal">
                    <Image Source="features.png" Width="24" Height="24" Margin="5"/>
                    <TextBlock Text="Windows Features"/>
                </StackPanel>
            </Button>
            <Button Name="RemoteDesktopBtn" Width="250" Margin="10">
                <StackPanel Orientation="Horizontal">
                    <Image Source="remote.png" Width="24" Height="24" Margin="5"/>
                    <TextBlock Text="Remote Desktop Users"/>
                </StackPanel>
            </Button>
            <Button Name="SysPropertiesBtn" Width="250" Margin="10">
                <StackPanel Orientation="Horizontal">
                    <Image Source="settings.png" Width="24" Height="24" Margin="5"/>
                    <TextBlock Text="System Properties"/>
                </StackPanel>
            </Button>
        </StackPanel>
    </Grid>
</Window>
"@

# Load the XAML
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# Define button click handlers
$window.LocalUsersBtn.Add_Click({ Start-Process "lusrmgr.msc" })
$window.FirewallBtn.Add_Click({ Start-Process "wf.msc" })
$window.FeaturesBtn.Add_Click({ Start-Process "optionalfeatures.exe" })
$window.RemoteDesktopBtn.Add_Click({ Start-Process "SystemPropertiesRemote.exe" })
$window.SysPropertiesBtn.Add_Click({ Start-Process "sysdm.cpl" })

# Display the UI
$window.ShowDialog()