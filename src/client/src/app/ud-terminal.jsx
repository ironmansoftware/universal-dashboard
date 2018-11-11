import React from 'react';
import Terminal from 'terminal-in-react';
import {fetchPostRaw} from './services/fetch-service.jsx';

export default class UDTerminal extends React.Component {
    render() {
        return (
            <Terminal 
                commandPassThrough={(cmd, print) => {

                    const text = cmd.join(' ');

                    fetchPostRaw(`/api/internal/component/terminal`, text, res => {
                        print(res);
                    });
                }} 
                watchConsoleLogging={true} 
                promptSymbol={"UD >"} 
                hideTopBar={false} 
                allowTabs={true} 
                startState={'maximised'} 
                backgroundColor='#07387e'
                color='#fff'/>
        )
    }
}