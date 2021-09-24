module "azurerm_virtual_machine" {
  source   = "../../"
  commands = <<-EOF
export runner_version="2.283.1"
export RUNNER_ALLOW_RUNASROOT="1"
wget -qO- "https://github.com/actions/runner/releases/download/v${runner_version}/actions-runner-linux-x64-${runner_version}.tar.gz" | tar xvz -
./config.sh --url "https://github.com/robertdebock" --token FaKeToKeN --runasservice --unattended --replace
sudo ./svc.sh install
sudo ./svc.sh start
EOF
}

output "public_ip_address" {
  value = module.azurerm_virtual_machine.public_ip_address
}
