var webpack = require('webpack');
var path = require('path');
var UglifyJsPlugin = require('uglifyjs-webpack-plugin');
var RemoveWebpackPlugin = require('remove-webpack-plugin');

var BUILD_DIR = path.resolve(__dirname, 'public');
var SRC_DIR = path.resolve(__dirname);
var APP_DIR = path.resolve(__dirname, 'src/app');

module.exports = (env) => {
  const isDev = env == 'development' || env == 'isolated';

  return {
    entry: {
      'index': __dirname + '/components/index.js'
    },
    output: {
      path: BUILD_DIR,
      filename: isDev ? '[name].bundle.js' : '[name].[hash].bundle.js',
      sourceMapFilename: '[name].[hash].bundle.map',
      publicPath: "",
      library: 'materialui',
      libraryTarget: 'var'
    },
    module: {
      rules: [{
          test: /\.(js|jsx)$/,
          exclude: [/node_modules/, /public/],
          loader: 'babel-loader'
        },
        {
          test: /\.css$/,
          loader: 'css-loader',
        },
        {
          test: /\.(eot|ttf|woff2?|otf|svg)$/,
          loader: 'file-loader'
        }
      ]
    },
    externals: {
      UniversalDashboard: 'UniversalDashboard',
      $: "$"
    },
    resolve: {
      extensions: ['.json', '.js', '.jsx'],
    },
    plugins: [
      // new RemoveWebpackPlugin(BUILD_DIR)
    ],
    devtool: "source-map"
  };
}