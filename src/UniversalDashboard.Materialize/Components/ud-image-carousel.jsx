import React from 'react';
import {Carousel} from "react-materialize";
import $ from "jquery";


export default class UdImageCarousel extends React.Component {

    constructor(props){
        super(props);

        this.onCarouselButtonClick = this.onCarouselButtonClick.bind(this);
        this.state = {
            slideUrlLink:null
        }
    }

    componentWillMount() {
        this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "syncElement") {
            this.loadData();
        }
    }

    onCarouselButtonClick(props){
        let currentButtonParentId = props.id
        let activeSlideHref = $(`#${currentButtonParentId} .carousel-item.active`)[0].attributes.href.value
        this.setState({
            slideUrlLink:activeSlideHref
        })
    }

    render(){

        // Carousel Items.
        var carouselItems = this.props.items.map((item) => {
            return <div
                href={item.url} 
                style={{
                    backgroundColor:item.backgroundColor,
                    backgroundImage:`url(${item.backgroundImage})`,
                    backgroundRepeat:item.backgroundRepeat,
                    backgroundSize:item.backgroundSize,
                    backgroundPosition: item.backgroundPosition,
                    color:item.fontColor
                }}>
                <h2 className={`${item.titlePosition}-align`} style={{
                    color:item.fontColor,
                    marginTop: '3em',
                    fontSize:'48px',
                    fontWeight:'800',
                    }}>{item.title}</h2>
                
                <p className={`${item.textPosition}-align`} style={{
                    color:item.fontColor,
                    marginTop: '1.5em',
                    fontSize:'36px',
                    fontWeight:'500'
                    }}>{item.text}</p>
            </div>
        });

        // Main carousel options.
        var options = {
            fullWidth:this.props.fullWidth,
            indicators:this.props.showIndecators,
            onCycleTo: () => {
                if(this.props.autoCycle){
                    this.onCarouselButtonClick(this.props)
                    setTimeout(() => {
                        $(`#${this.props.id}`).carousel('next')
                    },this.props.speed)
                }
                else{
                    this.onCarouselButtonClick(this.props)
                }        
            }
        }

        // Fix item button on main carousel.
        var btn = null;
        if(this.props.fixButton){
            btn = <a class="btn waves-effect white grey-text darken-text-2" href={this.state.slideUrlLink} target='_blank' >{this.props.buttonText}</a>
        };

        // Set the width and height of the carousel container 
        $(`div#${this.props.id}.carousel.carousel-slider`).css({
            "width":`${this.props.width}`,
            "height":`${this.props.height}`
        })

        return (
 
            <Carousel carouselId={this.props.id} options={options} fixedItem={btn}>
                {carouselItems}
            </Carousel>

        )
    }

}