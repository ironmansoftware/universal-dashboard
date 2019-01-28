import React from 'react';

class TabContainer extends React.Component {

    componentDidMount() {
        $('ul.tabs').tabs();
    }

    renderTabHeaders() {

        var tabIndex = 0;

        this.props.tabs.map(x => {
            tabIndex++;
            return (
                <li class="tab"><a href={`#${this.props.id}${tabIndex}`}>{x.text}</a></li>
            )
        });
    }

    renderTabContent() {
        var tabIndex = 0;

        this.props.tabs.map(x => {
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

        <div className="row">
        <div className="col s12">
          <ul className="tabs">
            {headers}
          </ul>
        </div>
        {content}
      </div>
    }
}

UniversalDashboard.register("tab-container", TabContainer);