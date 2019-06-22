import React from 'react';
import {Collapsible} from 'react-materialize';
import cx from 'classnames';
import UDIcon from './ud-icon';
import ReactInterval from 'react-interval';

export default class UDCollapsible extends React.Component {
    render() {

        var style = {
            color: this.props.color,
            backgroundColor: this.props.backgroundColor
        }

        var children = this.props.items.map(x => <UDCollapsibleItem {...x}/>);

        return (
            <Collapsible 
                id={this.props.id}
                accordion={this.props.accordion}
                popout={this.props.popout}
                className="ud-collapsible"
                style={style}
                >
                {children}
            </Collapsible>
        )
    }
}

class UDCollapsibleItem extends React.Component {

    constructor(props) {
        super(props);
        
        this.state = {
            content: props.content,
            error: null
        }
    }

    loadData() {
        if (this.props.endpoint) {
            UniversalDashboard.get("/api/internal/component/element/" + this.props.id, function(data) {
                if (data.error) {
                    this.setState({
                        content: data.error.message
                    })
                    return;
                }
    
                this.setState({
                    content: data,
                    error: null
                });
            }.bind(this));
        }
    }

    componentWillMount() {
        this.loadData();
    }

    render() {

        var style = {
            color: this.props.color,
            backgroundColor: this.props.backgroundColor
        }

      return [
        <li className={cx(this.props.className, { active: this.props.active })} {...this.props} style={style}>
          <div
            className={cx('collapsible-header', { active: this.props.active })}
          >
            {this.props.icon && <UDIcon icon={this.props.icon} style={{margin: '5px'}}/>}
            {this.props.title}
          </div>
          <div className="collapsible-body">{UniversalDashboard.renderComponent(this.state.content)}</div>
        </li>,
        <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>
      ]
    }
}