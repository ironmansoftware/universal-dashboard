@{  
    name       = "basic"
    definition = @{
        colors  = @{
            primary    = "#df5656"
            secondary  = "#fdc533"
            background = "#c1c1c1"
            text       = "#333"
            muted      = "#d6d6d6"
        }
        modes   = @{
            dark = @{
                primary    = "#eaa22222"
                secondary  = "#fdc533"
                background = "#333"
                text       = "#fff"
                muted      = "#ccc"
            }
        }
        avatars = @{
            small  = @{
                width        = '24px'
                height       = '24px'
                margin       = '16px'
                borderRadius = '50%'
            }
            medium = @{
                width        = '48px'
                height       = '48px'
                margin       = '16px'
                borderRadius = '50%'
            }
            large  = @{
                width        = '96px'
                height       = '96px'
                margin       = '16px'
                borderRadius = '50%'
            }
        }
        chart   = @{
            width   = $null
            height  = 400
            padding = @(48, 48, 48, 48)
            light   = @{
                colors       = @(
                    "#1890ff",
                    "#1f1f1f",
                    "#bfbfbf",
                    "#f0f0f0",
                    "#d9d9d9",
                    "#8c8c8c",
                    "#595959",
                    "#434343"
                )
                background   = @{
                    fill = "#ffffff"
                }
                defaultColor = "#1890ff"
                axis         = @{
                    label  = @{
                        textStyle = @{ 
                            fill = '#1890ff'
                        }
                    }
                    bottom = @{
                        label = @{
                            textStyle = @{ 
                                fill = '#1890ff'
                            }
                        }
                    }
                    left   = @{
                        label = @{
                            textStyle = @{ 
                                fill = '#1890ff'
                            }
                        }
                    }
                }
                title        = @{
                    fontSize      = 24
                    fill          = "#1f1f1f"
                    color         = "#1f1f1f"
                    alignWithAxis = $false
                    fontFamily    = 'fantasy'
                    marginLeft    = 48
                    marginBottom  = 0
                }
                description  = @{
                    fontSize      = 16
                    fill          = "#1f1f1f"
                    color         = "#1f1f1f"
                    alignWithAxis = $false
                    fontFamily    = 'fantasy'
                    marginLeft    = 48
                    marginBottom  = 0
                }
                legend       = @{ }
                tooltip      = @{ }
            }
            dark    = @{
                colors       = @(
                    "#d32029",
                    "#ffccc7",
                    "#ff7875",
                    "#ff4d4f",
                    "#cf1322",
                    "#a8071a",
                    "#820014",
                    "#5c0011"
                )
                background   = @{
                    fill = "#333333"
                }
                defaultColor = "#d32029"
                title        = @{
                    fontSize      = 32
                    fill          = "#797979"
                    color         = "#797979"
                    alignWithAxis = $false
                    fontFamily    = 'fantasy'
                    marginLeft    = 48
                    marginBottom  = 0
                }
                axis         = @{
                    label  = @{
                        textStyle = @{ 
                            fill = '#f37370'
                        }
                    }
                    bottom = @{
                        label = @{
                            textStyle = @{ 
                                fill = '#f37370'
                            }
                        }
                    }
                    left   = @{
                        label = @{
                            textStyle = @{ 
                                fill = '#f37370'
                            }
                        }
                    }
                }
                description  = @{
                    fontSize      = 16
                    fill          = "#797979"
                    alignWithAxis = $false
                    fontFamily    = 'fantasy'
                    marginLeft    = 48
                    marginBottom  = 0
                }
                legend       = @{ }
                tooltip      = @{ }
            }
        }
    }
}
