import Chip from "./chips"
import Icon from "./icon"
import Paper from "./paper"
import IconButton from "./icon-button"
import List from "./list"
import Button from "./button"
import Card from "./card"
import Pdf from "./pdf"; //this version has a bug render text not correct.

UniversalDashboard.register("mu-chip", Chip);
UniversalDashboard.register("mu-icon", Icon);
UniversalDashboard.register("mu-paper", Paper);
UniversalDashboard.register("mu-icon-button", IconButton);
UniversalDashboard.register("mu-list", List);
UniversalDashboard.register("mu-list-item", List);
UniversalDashboard.register("mu-button", Button);
UniversalDashboard.register("mu-card", Card);
UniversalDashboard.register("ud-pdf", Pdf);
