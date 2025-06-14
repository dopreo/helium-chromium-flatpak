# ungoogled-chromium flatpak

Please direct bug reports to the [official repository](
    https://github.com/ungoogled-software/ungoogled-chromium-flatpak) on GitHub.

### Extension points

To avoid having to expose more of the host file system in the sandbox but still
allowing extending Chromium, the following extension points are defined:
- io.github.imputnet.helium-chromium.Policy
- io.github.imputnet.helium-chromium.Extension
- io.github.imputnet.helium-chromium.NativeMessagingHost

#### io.github.imputnet.helium-chromium.Policy

This extension point can be used to configure custom Chromium policies and is
currently on version '1' and will make any policy under the `policies/managed` and
`policies/recommended` subdirectories available to Chromium.

#### io.github.imputnet.helium-chromium.Extension

Similarly to the above, but for Chromium extensions, this extension point is
also currently on version '1' and will make any extension under the `extensions`
subdirectory available to Chromium.

#### io.github.imputnet.helium-chromium.NativeMessagingHost

Also as above, but for [native messaging host](https://developer.chrome.com/docs/apps/nativeMessaging/)
support. As the other extension points, this extension point is also currently
on version '1' and exposes the `native-messaging-hosts` subdirectory to Chromium.

#### Using extension points

Extension points can be provided as regular flatpaks and an example is provided
under `examples/policies/block-dinosaur-game`. Important to note that extension points'
name must follow the syntax of `<ExtensionPointName>.<id>`, where `<ExtensionPointName>`
is one of the supported extension points above and `<id>` is a generic ID for this
specific extension point.

Flatpak also supports “unmanaged extensions”, allowing loading extensions installed
into `/var/lib/flatpak/extension` and `$XDG_DATA_HOME/flatpak/extension`.
This can be useful for example to allow system administrators to expose system installed
policies, extensions, etc.

One example of such "unmanaged extension" could be an extension point that exposes
all system policies installed under `/etc/chromium-browser/policies/{managed,recommended}`.
This could be done for example by creating an extension point under
`/var/lib/flatpak/extension/io.github.imputnet.helium-chromium.Policy.system-policies`, with
`/var/lib/flatpak/extension/io.github.imputnet.helium-chromium.Policy.system-policies/<arch>/<version>`
being a symlink to `/etc/chromium-browser`. Note that `<version>` must match the
extension point version.

Also, important to note that in the example above one would not be able to symlink the
actual policy file directly, as otherwise flatpak would not be able to resolve the
symlink when bind mounting the extension point.

### How do I install WideVine CDM?

1. Download and execute [widevine-install.sh](widevine-install.sh)
2. Restart Ungoogled Chromium **twice** for the changes to take effect.

### Miscellaneous Issues

For other problems please check https://ungoogled-software.github.io/ungoogled-chromium-wiki/faq
before creating an issue in this repository. However, keep in mind the following while
reading any document about Ungoogled Chromium:

* `~/.config/chromium` → `~/.var/app/io.github.imputnet.helium-chromium/config/chromium`

`~/.config/chromium` is not accessible to Ungoogled Chromium and the above path should be used
instead.

Also keep in mind that after making a change, make sure to do a `flatpak kill io.github.imputnet.helium-chromium`
to ensure that Ungoogled Chromium was actually restarted. This is because by default, Chromium
runs in the background after being started for the first time (closing the window doesn't actually
exit Chromium, just keeps it in a sort of "standby" mode).
