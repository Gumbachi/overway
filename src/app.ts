import { App } from "astal/gtk4";
import { Overway } from "./widget/window";
import style from "./style.scss";

App.start({
  css: style,
  instanceName: "overway",
  main() {
    Overway();
  },
});
