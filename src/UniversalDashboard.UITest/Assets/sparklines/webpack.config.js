var webpack = require('webpack');
var path = require('path');
//const UglifyJSPlugin = require('uglifyjs-webpack-plugin')

var BUILD_DIR = path.resolve(__dirname, 'public');
var SRC_DIR = path.resolve(__dirname);
var APP_DIR = path.resolve(__dirname, 'src/app');

module.exports = (env) => {
  const isDev = env == 'development' || env == 'isolated';

  return {
    entry: [__dirname + '/index.jsx'],
    output: {
      library: "UDSparklines",
      libraryTarget: "var",
      path: BUILD_DIR,
      filename: isDev ? 'sparklines.bundle.js' : 'sparklines.[hash].bundle.js',
      //sourceMapFilename: 'bundle.map',
      publicPath: "/"
    },
    module : {
      loaders : [
        { test: /\.(js|jsx)$/, exclude: [/node_modules/, /public/], loader: 'babel-loader'}
      ]
    },
    externals: {
      UniversalDashboard: 'UniversalDashboard'
    },
    resolve: {
      extensions: ['.json', '.js', '.jsx']
    },
    plugins: [
      // new UglifyJSPlugin({
      //   compress: {
      //     warnings: false
      //   },
      //   sourceMap: true
      // })
    ]
      ,
   // devtool: 'source-map',
  };
}

