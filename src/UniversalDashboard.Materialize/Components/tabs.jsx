import React, { Fragment } from 'react';
import M from 'materialize-css';

export default class TabContainer extends React.Component {

    componentDidMount() {
        M.Tabs.init(this.element);
        var instance = M.Tabs.getInstance(this.element);
        instance.updateTabIndicator();
    }

    renderTabHeaders() {

        var tabIndex = 0;

        return this.props.tabs.map(x => {
            tabIndex++;
            return (
                <li class="tab"><a href={`#${this.props.id}${tabIndex}`}>{x.text}</a></li>
            )
        });
    }

    renderTabContent() {
        var tabIndex = 0;

        return this.props.tabs.map(x => {
            tabIndex++;
            return (
                <div id={`${this.props.id}${tabIndex}`} className="col s12">
                    {UniversalDashboard.renderComponent(x.content)}
                </div>
            )
        });
    }

    render() {
        var headers = this.renderTabHeaders();
        var content = this.renderTabContent();

        return (
            <Fragment>
                <div>
                    <ul className="tabs" ref={x => this.element = x}>
                        {headers}
                    </ul>
                </div>
                {content}
            </Fragment>

        )
    }
}

