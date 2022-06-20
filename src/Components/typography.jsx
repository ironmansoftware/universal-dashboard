import React from 'react'
import PropTypes from 'prop-types'
import Typography from '@mui/material/Typography'
import { ReactInterval } from 'react-interval/lib/Component'
import classNames from 'classnames'

export default class UdMuTypography extends React.Component {
  state = {
    text: '',
    errorMessage: '',
    hasError: false,
  }

  onLoadData = () => {
    if (!this.props.isEndpoint && this.props.content === null) {
      this.setState({
        text: this.props.text,
      })
    }
    if (!this.props.isEndpoint && this.props.content !== null) {
      this.setState({
        text: this.props.content,
      })
    }
    if (this.props.isEndpoint && this.props.content !== null) {
      UniversalDashboard.get(
        `/api/internal/component/element/${this.props.id}`,
        data => {
          data.error
            ? this.setState({
              hasError: true,
              error: data.error,
              errorMessage: data.error.message,
            })
            : this.setState({ text: data })
        },
      )
    }
  }

  componentWillMount() {
    this.onLoadData()
  }

  onIncomingEvent = (eventName, event) => {
    if (event.type === 'syncElement') {
      this.onLoadData()
    }
  }

  componentDidUpdate(prevProps) {
    if (prevProps.id !== this.props.id) {
      this.onLoadData()
    }
  }

  render() {
    const {
      id,
      // classes,
      style,
      align,
      gutterBottom,
      noWrap,
      // isParagraph,
      variant,
      refreshInterval,
      // isEndpoint,
      autoRefresh,
    } = this.props
    const { text } = this.state

    const typo = (
      <Typography
        id={id}
        className={classNames('ud-mu-typography', this.props.className)}
        align={align}
        gutterBottom={gutterBottom}
        noWrap={noWrap}
        style={style}
        variant={variant} >
        {text}
        <ReactInterval
          timeout={refreshInterval * 1000}
          enabled={autoRefresh}
          callback={this.onLoadData}
        />
      </Typography>
    )

    return align ? <div style={{ textAlign: align }}>{typo}</div> : typo;
  }
}
