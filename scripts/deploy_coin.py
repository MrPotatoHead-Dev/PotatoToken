from brownie import PotatoToken, config, network
from scripts.helpful_scripts import get_account


def deploy_token():
    account = get_account()
    capped_amount = 10000000
    # it takes a capped supply amount && miner reward amount
    token = PotatoToken.deploy(
        capped_amount,
        1000000,
        {"from": account},
        publish_source=config["networks"][network.show_active()].get("verify", False),
    )

    print(token)
    return token


def main():
    deploy_token()
