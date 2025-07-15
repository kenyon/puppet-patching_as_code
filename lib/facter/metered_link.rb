# frozen_string_literal: true

Facter.add('metered_link') do
  confine kernel: 'windows'
  setcode do
    sysroot = ENV.fetch('SystemRoot', nil)
    powershell = "#{sysroot}\\system32\\WindowsPowerShell\\v1.0\\powershell.exe"
    # get the script path relative to facter Ruby program
    checker_script = File.join(
      __dir__,
      '..',
      'patching_as_code',
      'metered_link.ps1'
    )
    Facter::Util::Resolution.exec("#{powershell} -ExecutionPolicy Bypass -NoProfile -NoLogo -NonInteractive -File #{checker_script}").to_s == 'true'
  end
end
