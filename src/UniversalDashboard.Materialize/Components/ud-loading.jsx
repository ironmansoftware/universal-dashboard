import React from 'react';
import {Row, Col} from 'react-materialize';

export default class Loading extends React.Component {

    constructor() {
        super();

        this.state = {
            loadingOpts: true,
            showSplash: true, 
            textColor: '#FFFFFF',
            backgroundColor: "#252525", 
            text: "PowerShell Universal Dashboard",            
            cancelData: false
        }
    }    
    componentWillMount() {        
    }

    componentDidMount() {        
       //this.loadData();
    }

    componentWillUnmount(){
        this.state.cancelData = true;
    }

    setColors(){
        $('.loadingWrapper').css('color', this.state.textColor);
        $('.loadingWrapper').css('background-color', this.state.backgroundColor);
        // $('.ud-dashboard').css('background-color', this.state.backgroundColor);
        // $('.ud-dashboard').css('color', this.state.textColor);
    }

    loadData() {        
        UniversalDashboard.get("/api/internal/dashboard/loadingoptions", function(json){
            if(this.state.cancelData){
                return;
            }
            var propsToSet = Object.assign({}, this.state);
            
            if(json.showSplash !== null && json.showSplash !== undefined){
                propsToSet.showSplash = json.showSplash;
            }
            if(json.backgroundColor && json.backgroundColor !== null){
                propsToSet.backgroundColor = json.backgroundColor.htmlColor;
            }
            if(json.textColor){
                propsToSet.textColor = json.textColor.htmlColor;
            }
            if(json.text){
                propsToSet.text = json.text;
            }
            propsToSet.loadingOpts = false;

            if(!this.state.cancelData){
                this.setState(propsToSet);
                
            }
            this.setColors();
        }.bind(this));
    }

    render() {
        return <div className='loadingWrapper' style={{height: '100%', width: '100%', display: 'flex'}}>
                    <Row style={{height: '90vh', minHeight: '90vh', display: (!this.state.loadingOpts && this.state.showSplash) ? 'block' : 'none'}}>
                        <div className="valign-wrapper center-align" style={{height: '90vh'}}>
                            <div>
                                <h1>{this.state.text}</h1>
                                <div className="progress">
                                    <div className="indeterminate"></div>
                                </div>
                            </div>
                        </div>
                </Row>
               </div>
    }
}