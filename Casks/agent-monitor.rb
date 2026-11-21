cask "agent-monitor" do
  version "1.2.1"
  sha256 "bb447afc6f3f6b7c0071ebc5b9dfd14342f5a219c141c65c19e51e4d21d7ca50"

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
