var webpack = require('webpack');
var path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MonacoWebpackPlugin = require('monaco-editor-webpack-plugin');

var BUILD_DIR = path.resolve(__dirname, 'output');
var SRC_DIR = path.resolve(__dirname);
var APP_DIR = path.resolve(__dirname, 'src/app');

process.env.NODE_ENV = 'production'

module.exports = (env) => {
  const isDev = env == 'development' || env == 'isolated';

  return {
    entry: {
      'index': __dirname + '/app/index.jsx'
    },
    output: {
      path: BUILD_DIR,
      filename: isDev ? 'materialui.[name].bundle.js' : '[name].[contenthash].bundle.js',
      sourceMapFilename: '[name].[contenthash].bundle.map',
      library: 'materialui',
      libraryTarget: 'var'
    },
    module: {
      rules: [{
        test: /\.(js|jsx)$/,
        exclude: [/node_modules/, /output/],
        use: ['babel-loader']
      },
      { test: /\.css$/, use: ['style-loader', 'css-loader'] },
      {
        test: /\.(eot|ttf|woff2?|otf|svg|png)$/,
        type: 'asset/resource'
      }
      ]
    },
    optimization: {
      nodeEnv: "production",
      splitChunks: {
        chunks: "async"
      },
      removeEmptyChunks: true,
      emitOnErrors: true,
    },
    resolve: {
      extensions: ['.json', '.js', '.jsx', '.tsx', '.ts'],
      alias: {
        'universal-dashboard': path.resolve(__dirname, '../../npm/index.js'),
      }
    },
    plugins: [
      new MonacoWebpackPlugin(),
      new HtmlWebpackPlugin({
        favicon: path.resolve(SRC_DIR, 'favicon.ico'),
        template: path.resolve(SRC_DIR, 'index.html'),
        chunksSortMode: 'none'
      })
    ],
    devtool: "source-map",
    devServer: {
      historyApiFallback: true,
      port: 10000,
      // hot: true,
      compress: true,
      proxy: {
        '/api': {
          changeOrigin: true,
          //pathRewrite: { '^/api': '' },
          target: 'http://localhost:5000/',
          secure: true,
          logLevel: 'debug'
        },
        '/dashboardhub': {
          target: 'ws://localhost:5000',
          ws: true
        },
      }
    },
  };
}