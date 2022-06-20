import * as React from 'react';
import Timeline from '@mui/lab/Timeline';
import TimelineItem from '@mui/lab/TimelineItem';
import TimelineSeparator from '@mui/lab/TimelineSeparator';
import TimelineConnector from '@mui/lab/TimelineConnector';
import TimelineContent from '@mui/lab/TimelineContent';
import TimelineOppositeContent from '@mui/lab/TimelineOppositeContent';
import TimelineDot from '@mui/lab/TimelineDot';
import { withComponentFeatures } from "universal-dashboard";

const UDTimeline = (props) => {
    let children = props.children;
    if (!Array.isArray(children)) {
        children = [children];
    }

    return <Timeline position={props.position}>
        {children.map(x => {
            return (
                <TimelineItem>
                    {x.oppositeContent && (
                        <TimelineOppositeContent>
                            {props.render(x.oppositeContent)}
                        </TimelineOppositeContent>
                    )}
                    <TimelineSeparator>
                        <TimelineDot variant={x.variant} color={x.color}>
                            {x.icon && props.render(x.icon)}
                        </TimelineDot>
                        <TimelineConnector />
                    </TimelineSeparator>
                    <TimelineContent>
                        {props.render(x.content)}
                    </TimelineContent>
                </TimelineItem>
            )
        })}
    </Timeline>
}

export default withComponentFeatures(UDTimeline);