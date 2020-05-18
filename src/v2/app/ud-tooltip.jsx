import React from 'react';
import ReactTooltip from 'react-tooltip';

export default class UDTooltip extends React.Component {
    render()
    {
        var tooltipContent = this.props.tooltipContent;
        if (!Array.isArray(tooltipContent))
        {
            tooltipContent = [tooltipContent]
        }

        var content = this.props.content;
        if (!Array.isArray(content))
        {
            content = [content]
        }

        content = content.map(x => {
            return UniversalDashboard.renderComponent(x);
        });

        tooltipContent = tooltipContent.map(x => {
            if (typeof x === 'string' || x instanceof String)
            {
                return x;
            }

            return UniversalDashboard.renderComponent(x);
        });

        return (
            <React.Fragment>
                <a data-tip='' data-for={this.props.id} className={this.props.className}>{content}</a>
                <ReactTooltip id={this.props.id} effect={this.props.effect} place={this.props.place} type={this.props.tooltipType}>{tooltipContent}</ReactTooltip>
            </React.Fragment>
        )
    }
}