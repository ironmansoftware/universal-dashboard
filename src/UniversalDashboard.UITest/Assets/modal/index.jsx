import React from 'react';
import {Modal, Button} from 'react-materialize';

export default class UDModal extends React.Component {
    constructor() {
        super();

        this.state = {
            serverDateTime: ""
        }
    }

    componentWillMount() {
        UniversalDashboard.get("/component/element/" + this.props.id, function(data) {
            this.setState({
                serverDateTime: data.ServerTime
            })
        }.bind(this));
    }

    render() {
       return <Modal
                style={{color:'black'}}
                header={this.props.header}
                trigger={<Button>{this.props.buttonText}</Button>}>
                <p>{this.props.content}</p>
                <p>{this.state.serverDateTime}</p>
              </Modal>
    }
}

