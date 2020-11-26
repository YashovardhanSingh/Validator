from thenewboston.base_classes.fetch_primary_validator_config import FetchPrimaryValidatorConfig

from v1.tasks.sync_with_primary_validator import sync_with_primary_validator

"""
python3 manage.py set_primary_validator

Notes:
- this should be ran after initialize_validator

Running this script will:
- fetch config data from primary validator
- create a Validator instance using config data
- set that Validator as this nodes primary validator
- connect to the primary validator
- send a request to the primary validator for any missing historical confirmation blocks
"""


class Command(FetchPrimaryValidatorConfig):
    help = 'Fetch config from PV, create related Validator, set that Validator as the primary validator'

    def __init__(self, *args, **kwargs):
        """Inits Command class"""
        super().__init__(*args, **kwargs)
        if not self.unattended:
            self.stdout.write(self.style.SUCCESS('Enter primary validator information'))

    def handle(self, *args, **options):
        """Run script"""
        connected = False

        while not connected:
            self.required_input = {
                'ip_address': None,
                'port': None,
                'protocol': None
            }

            self.get_ip_address(value=options.get('ip_address'))
            self.get_protocol(value=options.get('protocol'))
            self.get_port(value=options.get('port'))

            try:
                config = self.fetch_validator_config()

                if not self.is_config_valid(config):
                    continue

                self.get_trust(value=options.get('trust'))
                self.handle_primary_validator_config(config)
            except Exception as e:
                self._error('Unable to connect')
                self._error(e)
                continue

            connected = True

        self.stdout.write(self.style.SUCCESS('Success'))

    def handle_primary_validator_config(self, primary_validator_config):
        """
        Sync with primary validator
        """

        self.stdout.write(self.style.SUCCESS('Syncing with primary validator...'))
        sync_with_primary_validator(
            config=primary_validator_config,
            trust=self.required_input['trust']
        )
