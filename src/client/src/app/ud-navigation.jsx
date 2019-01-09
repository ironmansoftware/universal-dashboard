import React from 'react';
import {Link} from 'react-router-dom';
import UdIcon from './ud-icon.jsx';

export default class UdNavigation extends React.Component {

    constructor() {
        super();

        this.state = {
            paused: false
        }
    }


    componentDidMount() {
        $(".menu-button").sideNav({
            menuWidth: 300,
            closeOnClick: true
        });
    }

    onTogglePauseCycling() {
        this.props.togglePaused();
        this.setState({
            paused: !this.state.paused
        })
    }

    render() {
        if (!this.props.pages || this.props.pages.length === 1) return <div/>;

        var links = this.props.pages.map(function(x, i) {

            if (x.name == null) return null;

            return <li key={x.name}><Link to={"/" + x.name.replace(/ /g, "-")}><UdIcon icon={x.icon}/> {x.name}</Link></li>;
        })

        var pauseToggle = null;
        if (this.props.showPauseToggle) {
            var pauseIcon = this.state.paused ? "play-circle" : "pause-circle";
            var words = this.state.paused ? "Cycle Pages"  : "Pause Page Cycling";

            pauseToggle = [<li><div class="divider"></div></li>,
                           <li><a href="#!" onClick={this.onTogglePauseCycling.bind(this)}><UdIcon icon={pauseIcon}/> {words}</a></li>
                          ]
        }

        return   [<div className="side-nav ud-page-navigation" id="navigation" >
                                        <div className="nav-wrapper">
                                        <ul className="right" style={{width: '100%'}}>
                                            {links}
                                            {pauseToggle}
                                        </ul>
                                    </div>
                </div>,
                <a href="#" className="menu-button" data-activates="navigation" style={{marginLeft: '25px', fontSize: '2.1rem'}}><UdIcon icon="bars"/></a>]
    }
}