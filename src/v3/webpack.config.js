var webpack = require('webpack');
var path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

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
      filename: isDev ? 'materialui.[name].bundle.js' : '[name].[hash].bundle.js',
      sourceMapFilename: '[name].[hash].bundle.map',
      library: 'materialui',
      libraryTarget: 'var'
    },
    module: {
      rules: [{
          test: /\.(js|jsx)$/,
          exclude: [/node_modules/, /output/],
          use: ['babel-loader']
        },
        { test: /\.css$/, loader: "style-loader!css-loader" },
        {
          test: /\.(eot|ttf|woff2?|otf|svg)$/,
          loader: 'file-loader'
        }
      ]
    },
    optimization: {
      nodeEnv: "production",
      splitChunks: {
        chunks: "async",
        minSize: 30000,
        maxSize: 0,
        minChunks: 1,
        maxAsyncRequests: 5,
        maxInitialRequests: 3,
        automaticNameDelimiter: "-",
        automaticNameMaxLength: 15,
        name: true,
      },
      removeEmptyChunks: true,
      noEmitOnErrors: false,
    },
    resolve: {
      extensions: ['.json', '.js', '.jsx'],
    },
    plugins: [
      new HtmlWebpackPlugin({
        favicon: path.resolve(SRC_DIR, 'favicon.ico'),
        template: path.resolve(SRC_DIR, 'index.html'),
        chunksSortMode: 'none'
      })
],
    devtool: "source-map",
    devServer: {
      disableHostCheck: true,
      historyApiFallback: true,
      port: 10000,
      // hot: true,
      compress: true,
      publicPath: '/',
      stats: "minimal",
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