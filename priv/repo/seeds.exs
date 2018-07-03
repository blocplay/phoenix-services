# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AppApi.Repo.insert!(%AppApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

AppApi.Repo.insert! %AppApi.Game{
        "name": "A Duel Hand Disaster: Trackher",
        "price": 8220000000000000,
        "description": "The only split-screen single player twin stick risk 'em up in which your score is meaningless unless you exist. If you do not extract you do not keep your score. Playing 'til death is not an option. Don't lose sight of your mission. Trackher.",
				"blockchain_id": 1,
        "metadata": %{
            "searchKeywords": "",
            "externalLinks": %{
                "gameURL": "https://www.aduelhanddisaster.com/",
                "forumURL": "",
                "statsURL": "",
                "manualURL": ""
            },
            "platformSpecs": [
                %{
                    "platform": "Windows",
                    "minimumSpecs": [
                        %{
                            "name": "OS Version",
                            "description": "Windows 8 x64"
                        }
                    ],
                    "recommendedSpecs": [
                        %{
                            "name": "OS Version",
                            "description": "Windows 10 x64"
                        }
                    ]
                }
            ],
            "releaseDate": 1525995996,
            "supportedLanguages": [
                %{
                    "name": "English",
                    "supports": [
                        "Interface",
                        "Full Audio",
                        "Subtitles"
                    ]
                }
            ],
            "genres": [
                "Action",
                "Indie",
                "Early Access"
            ],
            "players": [
                "Single-player"
            ],
            "virtualReality": [
                ""
            ],
            "legalNotice": "",
            "support": %{
                "url": "",
                "email": "",
                "phone": ""
            },
            "drm": %{
                "provider": "",
                "limit": ""
            },
            "agencyRatings": [
                %{
                    "rating": "",
                    "discriptor": ""
                }
            ],
            "googleAnalyticsID": "",
            "downloadableContent": "",
            "associatedDemos": "",
            "publisher": %{
                "name": "Ask An Enemy Studios"
            },
            "platforms": [
                "Windows",
                "OSX"
            ],
            "images": %{
                "teaser": %{
                    "url": "https://tokenplay.s3.amazonaws.com/media/1/teaser.png"
                },
                "cover": %{
                    "url": "https://tokenplay.s3.amazonaws.com/media/1/cover.png"
                }
            },
            "medias": [
                %{
                    "id": 1,
                    "type": "video",
                    "previewUrl": "https://tokenplay.s3.amazonaws.com/media/1/preview.png",
                    "title": "A Duel Hand Disaster: Trackher Preview",
                    "src": "https://tokenplay.s3.amazonaws.com/media/1/1.mp4"
                },
                %{
                    "id": 2,
                    "type": "video",
                    "previewUrl": "https://tokenplay.s3.amazonaws.com/media/1/preview.png",
                    "title": "A Duel Hand Disaster: Trackher Preview",
                    "src": "https://tokenplay.s3.amazonaws.com/media/1/2.mp4"
                }
            ],
            "package": %{
                "id": "ID012-12",
                "defaultDest": "/main/folder/destination",
                "installSize": 313802630,
                "downloaded": true
            },
            "rating": %{
                "numerator": 4.2,
                "denominator": 5,
                "populationSize": 8502306
            },
            "tokensEarned": 38501069,
        }
}

AppApi.Repo.insert! %AppApi.Game{
        "name": "Galaxy of Pen and Paper",
        "price": 24730000000000000,
				"blockchain_id": 2,
        "description": "Galaxy of Pen & Paper is a turn-based meta RPG about a group of players rolling dice in the year 1999! Create your own game master and RPG party, as they roleplay, explore distant planets in their imagination, fight weird aliens and save the galaxy in the era of dial-up internet and floppy disks!",
        "metadata": %{
	        "searchKeywords": "Indie, RPG",
	        "externalLinks": %{
	            "gameURL": "http://www.galaxyofpenandpaper.com/",
	            "forumURL": "",
	            "statsURL": "",
	            "manualURL": ""
	        },
	        "platformSpecs": [
	            %{
	                "platform": "Windows",
	                "minimumSpecs": [
	                    %{
	                        "name": "OS Version",
	                        "description": "Windows 8 x64"
	                    }
	                ],
	                "recommendedSpecs": [
	                    %{
	                        "name": "OS Version",
	                        "description": "Windows 10 x64"
	                    }
	                ]
	            }
	        ],
	        "releaseDate": 1525995996,
	        "supportedLanguages": [
	            %{
	                "name": "English",
	                "supports": [
	                    "Interface",
	                    "Full Audio",
	                    "Subtitles"
	                ]
	            }
	        ],
	        "genres": [
	            "RPG",
	            "Indie"
	        ],
	        "players": [
	            "Single-player"
	        ],
	        "virtualReality": [
	            ""
	        ],
	        "legalNotice": "",
	        "support": %{
	            "url": "",
	            "email": "",
	            "phone": ""
	        },
	        "drm": %{
	            "provider": "",
	            "limit": ""
	        },
	        "agencyRatings": [
	            %{
	                "rating": "",
	                "discriptor": ""
	            }
	        ],
	        "googleAnalyticsID": "",
	        "downloadableContent": "",
	        "associatedDemos": "",
	        "publisher": %{
	            "name": "Behold Studios"
	        },
	        "platforms": [
	            "Windows"
	        ],
	        "images": %{
	            "teaser": %{
	                "url": "https://tokenplay.s3.amazonaws.com/media/2/teaser.png"
	            },
	            "cover": %{
	                "url": "https://tokenplay.s3.amazonaws.com/media/2/cover.png"
	            }
	        },
	        "medias": [
	            %{
	                "id": 1,
	                "type": "video",
	                "previewUrl": "https://tokenplay.s3.amazonaws.com/media/2/preview.png",
	                "title": "A Duel Hand Disaster: Trackher Preview",
	                "src": "https://tokenplay.s3.amazonaws.com/media/2/1.mp4"
	            }
	        ],
	        "package": %{
	            "id": "ID012-12",
	            "defaultDest": "/main/folder/destination",
	            "installSize": 313802630,
	            "downloaded": true
	        },
	        "rating": %{
	            "numerator": 4.2,
	            "denominator": 5,
	            "populationSize": 8502306
	        },
	        "tokensEarned": 38501069
	      }
    }

AppApi.Repo.insert! %AppApi.Game{
        "name": "Mutant Football League",
        "price": 33030000000000000,
				"blockchain_id": 3,
        "description": "Mutants and monsters unleash maniacal carnage on the gridiron in this crazy gore fest of arcade-style football. Packed full of humor, intense online multiplayer action, and strategy.",
        "metadata": %{
	        "searchKeywords": "Action, Indie, Sports",
	        "externalLinks": %{
	            "gameURL": "http://www.mutantfootballleague.com/",
	            "forumURL": "",
	            "statsURL": "",
	            "manualURL": ""
	        },
	        "platformSpecs": [
	            %{
	                "platform": "Windows",
	                "minimumSpecs": [
	                    %{
	                        "name": "OS Version",
	                        "description": "Windows 8 x64"
	                    }
	                ],
	                "recommendedSpecs": [
	                    %{
	                        "name": "OS Version",
	                        "description": "Windows 10 x64"
	                    }
	                ]
	            }
	        ],
	        "releaseDate": 1525995996,
	        "supportedLanguages": [
	            %{
	                "name": "English",
	                "supports": [
	                    "Interface",
	                    "Full Audio",
	                    "Subtitles"
	                ]
	            }
	        ],
	        "genres": [
	            "Action",
	            "Indie",
	            "Sports"
	        ],
	        "players": [
	            "Single-player",
	            "Multi-player"
	        ],
	        "virtualReality": [
	            ""
	        ],
	        "legalNotice": "",
	        "support": %{
	            "url": "",
	            "email": "",
	            "phone": ""
	        },
	        "drm": %{
	            "provider": "",
	            "limit": ""
	        },
	        "agencyRatings": [
	            %{
	                "rating": "",
	                "discriptor": ""
	            }
	        ],
	        "googleAnalyticsID": "",
	        "downloadableContent": "",
	        "associatedDemos": "",
	        "publisher": %{
	            "name": "Digital Dreams Entertainment LLC"
	        },
	        "platforms": [
	            "Windows"
	        ],
	        "images": %{
	            "teaser": %{
	                "url": "https://tokenplay.s3.amazonaws.com/media/3/teaser.png"
	            },
	            "cover": %{
	                "url": "https://tokenplay.s3.amazonaws.com/media/3/cover.png"
	            }
	        },
	        "medias": [
	            %{
	                "id": 1,
	                "type": "video",
	                "previewUrl": "https://tokenplay.s3.amazonaws.com/media/3/preview.png",
	                "title": "Mutant Football League",
	                "src": "https://tokenplay.s3.amazonaws.com/media/3/1.mp4"
	            }
	        ],
	        "package": %{
	            "id": "ID012-12",
	            "defaultDest": "/main/folder/destination",
	            "installSize": 313802630,
	            "downloaded": true
	        },
	        "rating": %{
	            "numerator": 4.2,
	            "denominator": 5,
	            "populationSize": 8502306
	        },
	        "tokensEarned": 38501069
	      }
    }

AppApi.Repo.insert! %AppApi.Game{
        "name": "Chroma Squad",
        "price": 24770000000000000,
				"blockchain_id": 4,
        "description": "Chroma Squad is a tactical RPG about five stunt actors who decide to quit their jobs and start their own Power Rangers-inspired TV show! Cast actors, purchase equipment and upgrades for your studio, craft weapons and giant Mechas out of cardboard and duct tape.",
        "metadata": %{
	        "searchKeywords": "Indie, RPG, Strategy",
	        "externalLinks": %{
	            "gameURL": "http://www.mutantfootballleague.com/",
	            "forumURL": "",
	            "statsURL": "",
	            "manualURL": ""
	        },
	        "platformSpecs": [
	            %{
	                "platform": "Windows",
	                "minimumSpecs": [
	                    %{
	                        "name": "OS Version",
	                        "description": "Windows 8 x64"
	                    }
	                ],
	                "recommendedSpecs": [
	                    %{
	                        "name": "OS Version",
	                        "description": "Windows 10 x64"
	                    }
	                ]
	            }
	        ],
	        "releaseDate": 1525995996,
	        "supportedLanguages": [
	            %{
	                "name": "English",
	                "supports": [
	                    "Interface",
	                    "Full Audio",
	                    "Subtitles"
	                ]
	            }
	        ],
	        "genres": [
	            "RPG",
	            "Indie",
	            "Strategy"
	        ],
	        "players": [
	            "Single-player",
	            "Multi-player"
	        ],
	        "virtualReality": [
	            ""
	        ],
	        "legalNotice": "",
	        "support": %{
	            "url": "",
	            "email": "",
	            "phone": ""
	        },
	        "drm": %{
	            "provider": "",
	            "limit": ""
	        },
	        "agencyRatings": [
	            %{
	                "rating": "",
	                "discriptor": ""
	            }
	        ],
	        "googleAnalyticsID": "",
	        "downloadableContent": "",
	        "associatedDemos": "",
	        "publisher": %{
	            "name": "Behold Studios"
	        },
	        "platforms": [
	            "Windows"
	        ],
	        "images": %{
	            "teaser": %{
	                "url": "https://tokenplay.s3.amazonaws.com/media/4/teaser.png"
	            },
	            "cover": %{
	                "url": "https://tokenplay.s3.amazonaws.com/media/4/cover.png"
	            }
	        },
	        "medias": [
	            %{
	                "id": 1,
	                "type": "video",
	                "previewUrl": "https://tokenplay.s3.amazonaws.com/media/4/preview.png",
	                "title": "Chroma Squad",
	                "src": "https://tokenplay.s3.amazonaws.com/media/4/1.mp4"
	            }
	        ],
	        "package": %{
	            "id": "ID012-12",
	            "defaultDest": "/main/folder/destination",
	            "installSize": 313802630,
	            "downloaded": true
	        },
	        "rating": %{
	            "numerator": 4.2,
	            "denominator": 5,
	            "populationSize": 8502306
	        },
	        "tokensEarned": 38501069
	      },
    }

AppApi.Repo.insert! %AppApi.Game{
        "name": "Jennifer Wilde",
        "price": 24770000000000000,
				"blockchain_id": 5,
        "description": "Outsider Games is partnering with Irish comic book publisher Atomic Diner and Northern Ireland Screen to adapt the best-selling and award-winning comic book Jennifer Wilde as a Point & Click Adventure game.",
        "metadata": %{
	        "searchKeywords": "Indie, Point & Click Adventure",
	        "externalLinks": %{
	            "gameURL": "",
	            "forumURL": "",
	            "statsURL": "",
	            "manualURL": ""
	        },
	        "platformSpecs": [
	            %{
	                "platform": "Windows",
	                "minimumSpecs": [
	                    %{
	                        "name": "OS Version",
	                        "description": "Windows 8 x64"
	                    }
	                ],
	                "recommendedSpecs": [
	                    %{
	                        "name": "OS Version",
	                        "description": "Windows 10 x64"
	                    }
	                ]
	            }
	        ],
	        "releaseDate": 1525995996,
	        "supportedLanguages": [
	            %{
	                "name": "English",
	                "supports": [
	                    "Interface",
	                    "Full Audio",
	                    "Subtitles"
	                ]
	            }
	        ],
	        "genres": [
	            "Indie",
	            "Point & Click"
	        ],
	        "players": [
	            "Single-player"
	        ],
	        "virtualReality": [
	            ""
	        ],
	        "legalNotice": "",
	        "support": %{
	            "url": "",
	            "email": "",
	            "phone": ""
	        },
	        "drm": %{
	            "provider": "",
	            "limit": ""
	        },
	        "agencyRatings": [
	            %{
	                "rating": "",
	                "discriptor": ""
	            }
	        ],
	        "googleAnalyticsID": "",
	        "downloadableContent": "",
	        "associatedDemos": "",
	        "publisher": %{
	            "name": "Outsider Games"
	        },
	        "platforms": [
	            "Windows"
	        ],
	        "images": %{
	            "teaser": %{
	                "url": "https://tokenplay.s3.amazonaws.com/media/5/teaser.png"
	            },
	            "cover": %{
	                "url": "https://tokenplay.s3.amazonaws.com/media/5/cover.png"
	            }
	        },
	        "medias": [
	            %{
	                "id": 1,
	                "type": "video",
	                "previewUrl": "https://tokenplay.s3.amazonaws.com/media/5/preview.png",
	                "title": "Jennifer Wilde",
	                "src": "https://tokenplay.s3.amazonaws.com/media/5/1.mp4"
	            }
	        ],
	        "package": %{
	            "id": "ID012-12",
	            "defaultDest": "/main/folder/destination",
	            "installSize": 313802630,
	            "downloaded": true
	        },
	        "rating": %{
	            "numerator": 4.2,
	            "denominator": 5,
	            "populationSize": 8502306
	        },
	        "tokensEarned": 38501069
	      }
    }

AppApi.Repo.insert! %AppApi.Game{
        "name": "Wailing Heights",
        "price": 16510000000000000,
				"blockchain_id": 6,
        "description": "A body-hopping, musical adventure game, set in a horrific hamlet of monsters, with a story by Kevin Beimers (Hector: Badge of Carnage) and glorious 2D artwork from a host of illustrious comic book talent.",
        "metadata": %{
	        "searchKeywords": "Adventure, Indie",
	        "externalLinks": %{
	            "gameURL": "",
	            "forumURL": "",
	            "statsURL": "",
	            "manualURL": ""
	        },
	        "platformSpecs": [
	            %{
	                "platform": "Windows",
	                "minimumSpecs": [
	                    %{
	                        "name": "OS Version",
	                        "description": "Windows 8 x64"
	                    }
	                ],
	                "recommendedSpecs": [
	                    %{
	                        "name": "OS Version",
	                        "description": "Windows 10 x64"
	                    }
	                ]
	            }
	        ],
	        "releaseDate": 1525995996,
	        "supportedLanguages": [
	            %{
	                "name": "English",
	                "supports": [
	                    "Interface",
	                    "Full Audio",
	                    "Subtitles"
	                ]
	            }
	        ],
	        "genres": [
	            "Indie",
	            "Advenure"
	        ],
	        "players": [
	            "Single-player"
	        ],
	        "virtualReality": [
	            ""
	        ],
	        "legalNotice": "",
	        "support": %{
	            "url": "",
	            "email": "",
	            "phone": ""
	        },
	        "drm": %{
	            "provider": "",
	            "limit": ""
	        },
	        "agencyRatings": [
	            %{
	                "rating": "",
	                "discriptor": ""
	            }
	        ],
	        "googleAnalyticsID": "",
	        "downloadableContent": "",
	        "associatedDemos": "",
	        "publisher": %{
	            "name": "Outsider Games"
	        },
	        "platforms": [
	            "Windows"
	        ],
	        "images": %{
	            "teaser": %{
	                "url": "https://tokenplay.s3.amazonaws.com/media/6/teaser.png"
	            },
	            "cover": %{
	                "url": "https://tokenplay.s3.amazonaws.com/media/6/cover.png"
	            }
	        },
	        "medias": [
	            %{
	                "id": 1,
	                "type": "video",
	                "previewUrl": "https://tokenplay.s3.amazonaws.com/media/6/preview.png",
	                "title": "Wailing Heights",
	                "src": "https://tokenplay.s3.amazonaws.com/media/6/1.mp4"
	            }
	        ],
	        "package": %{
	            "id": "ID012-12",
	            "defaultDest": "/main/folder/destination",
	            "installSize": 313802630,
	            "downloaded": true
	        },
	        "rating": %{
	            "numerator": 4.2,
	            "denominator": 5,
	            "populationSize": 8502306
	        },
	        "tokensEarned": 38501069
	      }
    }

AppApi.Repo.insert! %AppApi.Game{
        "name": "Heavy Gear Assault",
        "price": 66180000000000000,
				"blockchain_id": 7,
        "description": "The world of Heavy Gear Assault is unforgiving â€” but so is your lust for glory. As a pilot on the distant planet Terra Nova, you play the high-stakes game of competitive Gear Dueling. Earn fame and fortune by making a name for yourself on the arena floor.",
        "metadata": %{
	        "searchKeywords": "Action, Indie, Simulation, Early Access",
	        "externalLinks": %{
	            "gameURL": "http://www.heavygear.com",
	            "forumURL": "",
	            "statsURL": "",
	            "manualURL": ""
	        },
	        "platformSpecs": [
	            %{
	                "platform": "Windows",
	                "minimumSpecs": [
	                    %{
	                        "name": "OS Version",
	                        "description": "Windows 8 x64"
	                    }
	                ],
	                "recommendedSpecs": [
	                    %{
	                        "name": "OS Version",
	                        "description": "Windows 10 x64"
	                    }
	                ]
	            }
	        ],
	        "releaseDate": 1525995996,
	        "supportedLanguages": [
	            %{
	                "name": "English",
	                "supports": [
	                    "Interface",
	                    "Full Audio",
	                    "Subtitles"
	                ]
	            }
	        ],
	        "genres": [
	            "Indie",
	            "Advenure"
	        ],
	        "players": [
	            "Multi-player"
	        ],
	        "virtualReality": [
	            ""
	        ],
	        "legalNotice": "",
	        "support": %{
	            "url": "",
	            "email": "",
	            "phone": ""
	        },
	        "drm": %{
	            "provider": "",
	            "limit": ""
	        },
	        "agencyRatings": [
	            %{
	                "rating": "",
	                "discriptor": ""
	            }
	        ],
	        "googleAnalyticsID": "",
	        "downloadableContent": "",
	        "associatedDemos": "",
	        "publisher": %{
	            "name": "Stompy Bot Productions"
	        },
	        "platforms": [
	            "Windows"
	        ],
	        "images": %{
	            "teaser": %{
	                "url": "https://tokenplay.s3.amazonaws.com/media/7/teaser.png"
	            },
	            "cover": %{
	                "url": "https://tokenplay.s3.amazonaws.com/media/7/cover.png"
	            }
	        },
	        "medias": [
	            %{
	                "id": 1,
	                "type": "video",
	                "previewUrl": "https://tokenplay.s3.amazonaws.com/media/7/preview.png",
	                "title": "Wailing Heights",
	                "src": "https://tokenplay.s3.amazonaws.com/media/7/1.mp4"
	            }
	        ],
	        "package": %{
	            "id": "ID012-12",
	            "defaultDest": "/main/folder/destination",
	            "installSize": 313802630,
	            "downloaded": true
	        },
	        "rating": %{
	            "numerator": 4.2,
	            "denominator": 5,
	            "populationSize": 8502306
	        },
	        "tokensEarned": 38501069
	      }
    }









