import React, { useState, useEffect } from 'react';
import ErrorCard from './error-card.jsx';
import ReactInterval from 'react-interval';
import { withComponentFeatures } from 'universal-dashboard';
import Skeleton from '@mui/material/Skeleton';
import makeStyles from '@mui/styles/makeStyles';
import UdNavBar from './ud-navbar';
import Toolbar from '@mui/material/Toolbar';

const useStyles = makeStyles((theme) => ({
    root: {
        backgroundColor: theme.palette.background.default,
        height: '100vh',
        display: props => props.navLayout === "permanent" ? 'flex' : null
    },
    main: {
        flexGrow: 1,
        padding: theme.spacing(3)
    }
}));

const UDPage = (props) => {
    const classes = useStyles(props);

    document.title = props.name;

    const [components, setComponents] = useState([]);
    const [headerContent, setHeaderContent] = useState([]);
    const [loading, setLoading] = useState(true);
    const [hasError, setHasError] = useState(false);
    const [errorMessage, setErrorMessage] = useState('');
    const [navigation, setNavigation] = useState(props.navigation);

    const loadData = () => {
        if (!props.match) {
            return;
        }

        var queryParams = {};

        for (var k in props.match.params) {
            if (props.match.params.hasOwnProperty(k)) {
                queryParams[k] = props.match.params[k];
            }
        }

        var esc = encodeURIComponent;
        var query = Object.keys(queryParams)
            .map(k => esc(k) + '=' + esc(queryParams[k]))
            .join('&');

        UniversalDashboard.get(`/api/internal/component/element/${props.id}?${query}`, async json => {
            if (json.error) {
                setErrorMessage(json.error.message);
                setHasError(true);
            }
            else {
                setComponents(json);
                setHasError(false);
            }

            if (props.headerContent) {
                const headerContentJson = await props.headerContent();
                const hContent = JSON.parse(headerContentJson);
                setHeaderContent(hContent);
            }

            if (props.loadNavigation) {
                const loadNavigationContent = await props.loadNavigation();
                const nav = JSON.parse(loadNavigationContent);
                setNavigation(nav);
            }

            setLoading(false);
        });
    }

    useEffect(() => {
        loadData();
        return () => { }
    }, true)

    if (hasError) {
        return <ErrorCard message={errorMessage} id={props.id} title={"An error occurred on this page"} />
    }

    if (loading) {
        if (props.onLoading) {
            return props.render(props.onLoading);
        }

        return <div className={classes.root}>
            <Skeleton />
            <Skeleton />
            <Skeleton />
        </div>
    }

    var childComponents = props.render(components);

    let content = null;
    if (props.blank) {
        content = <div className={classes.root}>
            {childComponents}
            <ReactInterval timeout={props.refreshInterval * 1000} enabled={props.autoRefresh} callback={loadData} />
        </div>
    }
    else {
        content = <div className={classes.root}>
            <UdNavBar
                pages={props.pages}
                title={props.name}
                history={props.history}
                id="defaultNavbar"
                fixed={props.navLayout === "permanent"}
                navigation={navigation}
                logo={props.logo}
                disableThemeToggle={props.disableThemeToggle}
                hideNavigation={props.hideNavigation}
                user={props.user}
                windowsAuth={props.windowsAuth}
                position={props.headerPosition}
                color={props.headerColor}
                backgroundColor={props.headerBackgroundColor}
                children={headerContent}
            >
            </UdNavBar>
            <main className={classes.main}>
                {props.navLayout === "permanent" ? <Toolbar /> : <React.Fragment />}
                {childComponents}
            </main>

            <ReactInterval timeout={props.refreshInterval * 1000} enabled={props.autoRefresh} callback={loadData} />
        </div>
    }

    return content;
}

export default withComponentFeatures(UDPage);