import torch
import torch.nn as nn
import torch.nn.functional as F

class CNNSmall(nn.Module):

    def __init__(self):
        super().__init__()
        self.conv_1 = nn.Conv2d(3, 6, 5)
        self.pool = nn.MaxPool2d(2, 2)
        self.conv_2 = nn.Conv2d(6, 16, 5)
        self.linear_1 = nn.Linear(16 * 5 * 5, 100)
        self.linear_2 = nn.Linear(100, 50)
        self.linear_3 = nn.Linear(50, 10)

    def forward(self, x):
        # first CNN layer
        x = self.pool(self.conv_1(x))
        # second CNN layer
        x = self.pool(self.conv_2(x))

        # flatten all dimensions except batch
        x = torch.flatten(x, 1)
        # linear layers
        x = self.linear_1(x)
        x = self.linear_2(x)
        x = self.linear_3(x)
        return x


class CNNModerate(nn.Module):

    def __init__(self):
        super().__init__()
        self.conv_1 = nn.Conv2d(3, 6, 5)
        self.pool = nn.MaxPool2d(2, 2)
        self.conv_2 = nn.Conv2d(6, 16, 5)
        self.linear_1 = nn.Linear(16 * 5 * 5, 120)
        self.linear_2 = nn.Linear(120, 84)
        self.linear_3 = nn.Linear(84, 10)
        self.dropout = nn.Dropout()

    def forward(self, x):
        # first CNN layer
        x = self.pool(F.relu(self.conv_1(x)))
        # second CNN layer
        x = self.pool(F.relu(self.conv_2(x)))

        # flatten all dimensions except batch
        x = torch.flatten(x, 1)
        # linear layers
        x = self.dropout(F.relu(self.linear_1(x)))
        x = self.dropout(F.relu(self.linear_2(x)))
        x = self.linear_3(x)
        return x

class CNNBatchnorm(nn.Module):

    def __init__(self):
        super().__init__()
        self.conv_1 = nn.Conv2d(3, 6, 5)
        self.pool = nn.MaxPool2d(2, 2)
        self.conv_2 = nn.Conv2d(6, 16, 5)
        self.conv_2_bn = nn.BatchNorm2d(16)
        
        self.linear_1 = nn.Linear(16 * 5 * 5, 120)
        self.linear_1_bn = nn.BatchNorm1d(120)
        self.linear_2 = nn.Linear(120, 84)
        self.linear_3 = nn.Linear(84, 10)
        self.dropout = nn.Dropout()

    def forward(self, x):
        # first CNN layer
        x = self.pool(F.relu(self.conv_1(x)))
        # second CNN layer
        x = self.pool(F.relu(self.conv_2_bn(self.conv_2(x))))

        # flatten all dimensions except batch
        x = torch.flatten(x, 1)
        # linear layers
        x = self.dropout(F.relu(self.linear_1_bn(self.linear_1(x))))
        x = self.dropout(F.relu(self.linear_2(x)))
        x = self.linear_3(x)
        return x

class CNNBig(nn.Module):
    def __init__(self):
        super().__init__()
        self.network = nn.Sequential(
            nn.Conv2d(3, 32, kernel_size=3, padding=1),
            nn.ReLU(),
            nn.Conv2d(32, 64, kernel_size=3, stride=1, padding=1),
            nn.ReLU(),
            nn.MaxPool2d(2, 2), # output: 64 x 16 x 16
            nn.BatchNorm2d(64),

            nn.Conv2d(64, 128, kernel_size=3, stride=1, padding=1),
            nn.ReLU(),
            nn.Conv2d(128, 128, kernel_size=3, stride=1, padding=1),
            nn.ReLU(),
            nn.MaxPool2d(2, 2), # output: 128 x 8 x 8
            nn.BatchNorm2d(128),

            nn.Conv2d(128, 256, kernel_size=3, stride=1, padding=1),
            nn.ReLU(),
            nn.Conv2d(256, 256, kernel_size=3, stride=1, padding=1),
            nn.ReLU(),
            nn.MaxPool2d(2, 2), # output: 256 x 4 x 4
            nn.BatchNorm2d(256),

            nn.Flatten(), 
            nn.Linear(256*4*4, 1024),
            nn.ReLU(),
            nn.Linear(1024, 512),
            nn.ReLU(),
            nn.Linear(512, 10))
        
    def forward(self, x):
        return self.network(x)

VGG_11: str = 'VGG11'
VGG_16: str = 'VGG16'

cfg = {
    'VGG11': [64, 'M', 128, 'M', 256, 256, 'M', 512, 512, 'M', 512, 512, 'M'],
    'VGG16': [64, 64, 'M', 128, 128, 'M', 256, 256, 256, 'M', 512, 512, 512, 'M', 512, 512, 512, 'M'],
}


class VGG(nn.Module):
    def __init__(self, vgg_name):
        super(VGG, self).__init__()
        self.features = self._make_layers(cfg[vgg_name])
        self.classifier = nn.Linear(512, 10)

    def forward(self, x):
        out = self.features(x)
        out = out.view(out.size(0), -1)
        out = self.classifier(out)
        return out

    def _make_layers(self, cfg):
        layers = []
        in_channels = 3
        for x in cfg:
            if x == 'M':
                layers += [nn.MaxPool2d(kernel_size=2, stride=2)]
            else:
                layers += [nn.Conv2d(in_channels, x, kernel_size=3, padding=1),
                           nn.BatchNorm2d(x),
                           nn.ReLU(inplace=True)]
                in_channels = x
        layers += [nn.AvgPool2d(kernel_size=1, stride=1)]
        return nn.Sequential(*layers)



if __name__ == '__main__':
    model = CNNBig()
    # model = VGG('VGG16')
    x = torch.randn(2, 3, 32, 32)
    y = model(x)
    print(y.size())
