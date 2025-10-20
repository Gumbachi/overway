
howdy:
  @echo "Howdy"

run:
  qs -p ~/code/overway

@fix:
  - rm .qmlls.ini; touch .qmlls.ini
  - timeout 0.5s just run &>/dev/null

@list:
  qs list --all
