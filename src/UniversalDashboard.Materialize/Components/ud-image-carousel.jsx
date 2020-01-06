import React, { useRef, useContext, useEffect, useState } from 'react';
import { Slider, Slide, Caption } from "react-materialize";

const UDImageCarousel = ({ items, ...props }) => {

    return <Slider
        fullscreen={false}
        options={{
            duration: 500,
            height: 400,
            indicators: true,
            interval: 6000
        }}>
        {items.map(item => <Slide style={...item.style} image={<a href={item.url}><img alt="" src={item.imageSource} /></a>} />)}
    </Slider>
}

export default UDImageCarousel