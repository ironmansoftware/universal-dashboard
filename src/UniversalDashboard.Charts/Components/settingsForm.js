import { Form, Input, Select, Tooltip, Button } from 'antd'
import React from 'react'
import { Switch } from 'antd/es'
const { Option } = Select

export default () => {
  const onFinish = values => {
    console.log('Received values of form: ', values)
  }

  return (
    <Form
      name="complex-form"
      onFinish={onFinish}
      labelCol={{ span: 8 }}
      wrapperCol={{ span: 16 }}
    >
      <Form.Item label="Username">
        <Form.Item
          name="username"
          noStyle
          rules={[{ required: true, message: 'Username is required' }]}
        >
          <Input style={{ width: 160 }} placeholder="Please input" />
        </Form.Item>
        <Tooltip title="Useful information">
          <a href="#API" style={{ marginLeft: 8 }}>
            Need Help?
          </a>
        </Tooltip>
      </Form.Item>
      <Form.Item label="Data">
        <Input.Group compact>
          <Form.Item
            name={['data', 'refresh']}
            noStyle
            rules={[{ required: false}]}
          >
            <Select placeholder="Select refresh interval">
              <Option value="off">Off</Option>
              <Option value="5s">5 seconds</Option>
              <Option value="1m">1 minutes</Option>
              <Option value="5m">5 minutes</Option>
              <Option value="10m">10 minutes</Option>
              <Option value="15m">15 minutes</Option>
              <Option value="30m">30 minutes</Option>
              <Option value="1h">1 hour</Option>
            </Select>
          </Form.Item>
          <Form.Item
            name={['data', 'timeline']}
            noStyle
            rules={[{ required: false }]}
          >
            <Select placeholder="Select time range">
              <Option value="l5m">Last 5 minutes</Option>
              <Option value="l15m">Last 15 minutes</Option>
              <Option value="l30m">Last 30 minutes</Option>
              <Option value="l1h">Last 1 hour</Option>
              <Option value="l3h">Last 3 hours</Option>
              <Option value="l5h">Last 5 hours</Option>
            </Select>
          </Form.Item>
        </Input.Group>
      </Form.Item>
      <Form.Item label="Statistic" style={{ marginBottom: 0 }}>
        <Form.Item
          name={["statistic","min"]}
          rules={[{ required: false }]}
          style={{ display: 'inline-block', marginRight: 8 }}
        >
          <Switch size="small" />
        </Form.Item>
        <Form.Item
          name={["statistic","avg"]}
          rules={[{ required: false }]}
          style={{ display: 'inline-block' }}
        >
          <Switch size="small" />
        </Form.Item>
        <Form.Item
          name={["statistic","max"]}
          rules={[{ required: false }]}
          style={{ display: 'inline-block', marginRight: 8 }}
        >
          <Switch size="small" />
        </Form.Item>
      </Form.Item>
      <Form.Item label=" " colon={false}>
        <Button type="primary" htmlType="submit">
          Submit
        </Button>
      </Form.Item>
    </Form>
  )
}
