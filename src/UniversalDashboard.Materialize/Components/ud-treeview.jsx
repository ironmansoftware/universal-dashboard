import React from 'react';
import {Treebeard, decorators} from 'react-treebeard';


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

        if (this.props.hasCallback) {
            UniversalDashboard.post('/api/internal/component/element/' + this.props.id, { nodeId: node.id}, function(data) {
                node.children = data;
                if(this.state.cursor){this.state.cursor.active = false;}
                
                node.active = true;
                
                if(node.children){ 
                    node.toggled = toggled; 
                }
    
                this.setState({ cursor: node })
                
            }.bind(this))
        }
        else {
            if(this.state.cursor){this.state.cursor.active = false;}
            node.active = true;
            if(node.children){ 
                node.toggled = toggled; 
            }
            this.setState({ cursor: node })
        }


    }

    render(){

        decorators.Header = ({style, node}) => {
            const iconType = node.icon;
            const iconClass = `fa fa-${iconType}`;
            const iconStyle = {marginRight: '5px'};
        
            return (
                <div style={style.base} id={node.id}>
                    <div style={style.title}>
                        <i className={iconClass} style={iconStyle}/>
        
                        {node.name}
                    </div>
                </div>
            );
        };

        var style = {
            tree: {
                base: {
                    listStyle: 'none',
                    backgroundColor: this.props.backgroundColor,
                    margin: 0,
                    marginTop: '5px',
                    padding: 0,
                    color: this.props.fontColor,
                    fontFamily: 'lucida grande ,tahoma,verdana,arial,sans-serif',
                    fontSize: '14px'
                },
                node: {
                    base: {
                        position: 'relative'
                    },
                    link: {
                        cursor: 'pointer',
                        position: 'relative',
                        padding: '0px 5px',
                        display: 'block'
                    },
                    activeLink: {
                        background: this.props.activeBackgroundColor
                    },
                    toggle: {
                        base: {
                            position: 'relative',
                            display: 'inline-block',
                            verticalAlign: 'top',
                            marginLeft: '-5px',
                            height: '24px',
                            width: '24px'
                        },
                        wrapper: {
                            position: 'absolute',
                            top: '50%',
                            left: '50%',
                            margin: '-7px 0 0 -7px',
                            height: '14px'
                        },
                        height: 14,
                        width: 14,
                        arrow: {
                            fill: this.props.toggleColor,
                            strokeWidth: 0
                        }
                    },
                    header: {
                        base: {
                            display: 'inline-block',
                            verticalAlign: 'top',
                            color: this.props.fontColor
                        },
                        connector: {
                            width: '2px',
                            height: '12px',
                            borderLeft: 'solid 2px black',
                            borderBottom: 'solid 2px black',
                            position: 'absolute',
                            top: '0px',
                            left: '-21px'
                        },
                        title: {
                            lineHeight: '24px',
                            verticalAlign: 'middle'
                        }
                    },
                    subtree: {
                        listStyle: 'none',
                        paddingLeft: '19px'
                    },
                    loading: {
                        color: '#E2C089'
                    }
                }
            }
        };

        return (
            <Treebeard
                data={this.state.data}
                onToggle={this.onToggle}
                style={style}
            />
        );
    }
}