from tensorflow import keras
from tensorflow.keras import Sequential, layers
from tensorflow.keras.layers import Conv2D, MaxPooling2D, Flatten, Dropout, Dense
from tensorflow.keras.layers.experimental import RandomFourierFeatures

num_classes: int = 10


def get_convolutional_model(input_shape: tuple = (28, 28, 1)) -> Sequential:
    model = Sequential(
        [
            keras.Input(shape=input_shape),
            Conv2D(32, kernel_size=(3, 3), activation="relu"),
            MaxPooling2D(pool_size=(2, 2)),
            Conv2D(64, kernel_size=(3, 3), activation="relu"),
            MaxPooling2D(pool_size=(2, 2)),
            Flatten(),
            Dropout(0.5),
            Dense(num_classes, activation="softmax"),
        ]
    )

    model.compile(loss='categorical_crossentropy',
                  optimizer='adam', metrics=['accuracy'])

    return model


def get_svm_model(learning_rate=1e-3) -> Sequential:
    model = Sequential(
        [
            keras.Input(shape=(784,)),
            RandomFourierFeatures(
                output_dim=4096, scale=10.0, kernel_initializer='gaussian'
            ),
            layers.Dense(units=10),
        ]
    )

    model.compile(
        optimizer=keras.optimizers.Adam(learning_rate=learning_rate),
        loss=keras.losses.hinge,
        metrics=[keras.metrics.CategoricalAccuracy(name='acc')],
    )

    return model
