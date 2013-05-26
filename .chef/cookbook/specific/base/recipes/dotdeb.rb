apt_repository "dotdeb" do
  uri "http://packages.dotdeb.org"
  distribution "wheezy"
  components ["all"]
  key "http://www.dotdeb.org/dotdeb.gpg"
end
