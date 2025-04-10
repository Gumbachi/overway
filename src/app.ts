import { App } from "astal/gtk4";
import { Overway } from "./widget/Window";

App.start({
  instanceName: "overway",
  main() {
    Overway();
  },
});
