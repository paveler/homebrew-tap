cask "agent-monitor" do
  version "1.0.0"
  sha256 "8a2df947c93c8064bdf6ec64c63a84c4211f87e5491a6f1ed5ef55bc56831f26"

  url "https://github.com/paveler/agent-monitor/releases/download/v#{version}/AgentMonitor-#{version}.dmg"
  name "Agent Monitor"
  desc "Desktop widgets for Claude Code and Codex usage limits and waiting agents"
  homepage "https://github.com/paveler/agent-monitor"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "AgentMonitor.app"

  # Ad-hoc signed, not notarized yet: clear the quarantine flag so macOS opens it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/AgentMonitor.app"]
  end

  uninstall quit: "com.pavelershov.agentmonitor"

  zap trash: "~/Library/Application Support/AgentMonitor"

  caveats <<~EOS
    Open Agent Monitor from Applications, then:
      • add the widget: right-click the desktop → Edit Widgets… → Agent Monitor
      • connect your agents: menu bar icon → Integrations
    Before uninstalling, disconnect the agents in Integrations to remove the hooks.
  EOS
end
