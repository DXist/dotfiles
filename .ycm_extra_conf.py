def Settings(**kwargs):
    if kwargs["language"] == "rust":
        return {
            "ls": {
                "rust-analyzer": {
                    "checkOnSave": {
                        "enable": False,
                    }
                }
            }
        }
