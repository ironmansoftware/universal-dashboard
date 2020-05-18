import React from 'react';
import { Slider, Slide } from "react-materialize";

const UDImageCarousel = ({ items, ...props }) => {

    return <Slider {...props}>
        {
            items.map(
                item => <Slide
                    style={{ ...item.style }}
                    image={
                        <a href={item.url}>
                            <img alt="" src={item.imageSource} />
                        </a>
                    }
                />
            )
        }
    </Slider>
}

export default UDImageCarousel