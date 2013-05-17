execute "Change shell to ZSH" do
  command "sudo chsh -s $(which zsh) vagrant"
end
