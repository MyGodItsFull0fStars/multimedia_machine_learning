import torch


def get_torch_device(include_mps: bool = True):
    return torch.device(get_torch_device_as_string(include_mps))


def get_torch_device_as_string(include_mps: bool = True):
    if torch.cuda.is_available():
        return 'cuda'
    elif include_mps and torch.has_mps:
        return 'mps'
    else:
        return 'cpu'


if __name__ == '__main__':
    pass
