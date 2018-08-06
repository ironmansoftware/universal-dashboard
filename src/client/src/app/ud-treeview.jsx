import React from 'react';
import {Treebeard} from 'react-treebeard';
import {fetchPost} from './services/fetch-service';

export default class UDTreeView extends React.Component {
    constructor(props){
        super(props);
        this.state = {
            data : this.props.node
        };
        this.onToggle = this.onToggle.bind(this);
    }

    onToggle(node, toggled)
    {
        fetchPost('/component/element/' + this.props.id, { nodeId: node.id}, function(data) {
            node.children = data;
            if(this.state.cursor){this.state.cursor.active = false;}
            node.active = true;
            if(node.children){ node.toggled = toggled; }
            this.setState({ cursor: node })
        }.bind(this))
    }

    render(){
        return (
            <Treebeard
                data={this.state.data}
                onToggle={this.onToggle}
            />
        );
    }
}