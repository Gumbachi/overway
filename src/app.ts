import { App } from "astal/gtk4";
import style from "./style.scss";
import Bar from "./widget/Bar";
import { Overway } from "./widget/Window";

App.start({
  css: style,
  main() {
    App.get_monitors().map(Bar);
    Overway();
  },
});
