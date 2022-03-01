import "./style.css";
import { Elm } from "./src/Main.elm";
// import Transitions from "./vendor/Transitions.js";
import Transitions from "elm-transitions";

const root = document.querySelector("#app div");
const app = Elm.Main.init({ node: root });

Transitions.start(app);
