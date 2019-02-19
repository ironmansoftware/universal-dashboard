var webpack = require('webpack');
var path = require('path');

var BUILD_DIR = path.resolve(__dirname, 'public');
var SRC_DIR = path.resolve(__dirname);
var APP_DIR = path.resolve(__dirname, 'src/app');

module.exports = (env) => {
  const isDev = env == 'development' || env == 'isolated';

  return {
    entry: {
      'tabs' : __dirname + '/components/tabs.jsx'
    },
    output: {
      path: BUILD_DIR,
      filename: isDev ? '[name].bundle.js' : '[name].[hash].bundle.js',
      //sourceMapFilename: 'bundle.map',
      publicPath: "/"
    },
    module : {
      loaders : [
        { test: /\.(js|jsx)$/, exclude: [/node_modules/, /public/], loader: 'babel-loader'}
      ]
    },
    externals: {
      UniversalDashboard: 'UniversalDashboard',
      $: "$"
    },
    resolve: {
      extensions: ['.json', '.js', '.jsx']
    },
    plugins: [
      new webpack.ProvidePlugin({
        React: "React", react: "React", "window.react": "React", "window.React": "React"
    }),
    new webpack.optimize.UglifyJsPlugin()
    ]
  };
}

