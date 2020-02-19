import React from 'react';
import { Layout, Typography } from 'antd';

const { Header, Content, Footer } = Layout;

export default class UDSandbox extends React.Component
{
    render()
    {
        return (
        <Layout>
            <Header>
                <Typography>Universal Dashboard Sandbox</Typography>
            </Header>
            <Content style={{ padding: '0 50px' }}>

            </Content>
            <Footer style={{ textAlign: 'center' }}>Copyright 2020 Ironman Software, LLC </Footer>
        </Layout>
        )
    }
}