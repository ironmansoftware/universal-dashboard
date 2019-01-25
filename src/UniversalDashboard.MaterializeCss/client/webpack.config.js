var webpack = require('webpack');
var path = require('path');

var BUILD_DIR = path.resolve(__dirname, 'public');
var SRC_DIR = path.resolve(__dirname);
var APP_DIR = path.resolve(__dirname, 'src/app');

module.exports = (env) => {
  const isDev = env == 'development' || env == 'isolated';

  return {
    entry: __dirname + '/index.jsx',
    output: {
      library: "UDCharts",
      libraryTarget: "var",
      path: BUILD_DIR,
      filename: isDev ? 'materialize.bundle.js' : 'materialize.[hash].bundle.js',
      //sourceMapFilename: 'bundle.map',
      publicPath: "/"
    },
    module : {
      rules : [
        { test: /\.css$/, loader: "style-loader!css-loader" },
        { test: /\.(js|jsx)$/, exclude: [/node_modules/, /public/], loader: 'babel-loader'},
        { test: /\.(eot|ttf|woff2?|otf|svg)$/, loader:'file-loader' }
      ]
    },
    externals: {
      UniversalDashboard: 'UniversalDashboard'
    },
    resolve: {
      extensions: ['.json', '.js', '.jsx']
    },
    plugins: [
      new webpack.ProvidePlugin({
        React: "React", react: "React", "window.react": "React", "window.React": "React"
    }),
    //new webpack.optimize.UglifyJsPlugin()
    ]
  };
}

