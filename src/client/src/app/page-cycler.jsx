import React from 'react';
import ReactInterval from 'react-interval';
import {withRouter} from 'react-router-dom';

export default class PageCycler extends React.Component {
    constructor() {
        super();
    
        this.state = {
          currentPageIndex: 0
        }
      }

    cyclePage() {
    
        var currentPageIndex = this.state.currentPageIndex + 1;
        if (this.state.currentPageIndex === this.props.pages.length - 1) {
            currentPageIndex = 0;
        }
    
        this.setState({
            currentPageIndex: currentPageIndex
        });

        if (this.props.pages[currentPageIndex].name == null) {
            this.props.history.push(this.props.pages[currentPageIndex].url)
        }
        else {
            this.props.history.push("/" + this.props.pages[currentPageIndex].name.replace(" ", "-"))
        }

        
    }

    render() {
        return <ReactInterval timeout={this.props.cyclePagesInterval * 1000} enabled={this.props.cyclePages} callback={this.cyclePage.bind(this)}/>
    }
}

PageCycler = withRouter(PageCycler);

