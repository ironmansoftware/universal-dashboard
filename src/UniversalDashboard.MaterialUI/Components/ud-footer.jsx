import React from 'react';

export default class UdFooter extends React.Component {
    render() {
        if (this.props.footer == null) {
            return <footer className="page-footer ud-footer" style={{backgroundColor: this.props.backgroundColor, color: this.props.fontColor}}>
                <div className="footer-copyright">
                    <div className="container">
                        <a className="grey-text text-lighten-4 right" href="http://www.poshud.com">Created with PowerShell Universal Dashboard</a>
                    </div>
                </div>
            </footer>
        } else {
            var links = null;
            if (this.props.footer.links) {
                links = this.props.footer.links.map(function(x, i) {
                    return <UdLink {...x} key={x.url} className="grey-text text-lighten-4"/>
                });
            }

            var backgroundColor = this.props.footer.backgroundColor ? this.props.footer.backgroundColor : this.props.backgroundColor;
            var fontColor = this.props.footer.fontColor ? this.props.footer.fontColor : this.props.fontColor;

            return <footer className="page-footer ud-footer" style={{backgroundColor: backgroundColor, color: fontColor}}>
                <div className="footer-copyright">
                    <div className="container">
                        {this.props.footer.copyright}
                        <div className="right">
                            {links}
                        </div>
                        <a className="grey-text text-lighten-4 right" href="http://www.poshud.com">Created with PowerShell Universal Dashboard</a>
                    </div>
                </div>
            </footer>
        }
    }
}